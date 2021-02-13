# frozen_string_literal: true

module OperationHelpers
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def call_async(params, _opts = {})
      op_params = {
          op_class_name: name,
          op_params: params
      }

      # TODO: use `opts` for confgis like throw exceptions or not, retries etc.
      # set(queue: :critical)
      # https://github.com/mperham/sidekiq/wiki/Advanced-Options
      TrailblazerOperationAsyncWorker.perform_async(op_params)
    end
  end

  def handle_validation_errors(ctx, wrap_errors_key = nil)
    return true unless ctx[:form].errors.present?

    errors = ctx[:form].errors
    errors.each do |attr, messages|
      if messages.is_a?(Hash)
        # For array validations etc.
        # TODO: check how it will work
        messages.each do |attr, messages|
          add_error(ctx, attr, messages.join(', '))
        end
      else
        # for edge cases when we have an error like this { filters: { id: 'bla-bla-bla' } }
        attr, messages = parse_nested_error(messages) if attr.eql?(wrap_errors_key)
        add_error(ctx, attr, messages)
      end
    end
    false
  end

  def merge_operation_result(result, ctx, keys = [])
    merge_errors(ctx, result[:errors]) if result[:errors].present?
    merge_context_keys(ctx, result, keys) # if result.success?

    ctx
  end

  def merge_errors(ctx, errors)
    errors.each { |attr, error| add_error(ctx, attr, error) }
  end

  def merge_context_keys(ctx, result, keys)
    keys.each do |key|
      if ctx[key].is_a?(Hash) && result[key].is_a?(Hash)
        ctx[key].merge!(result[key])
      else
        ctx[key] = result[key]
      end
    end
  end

  def add_error(ctx, attr, error)
    ctx[:errors] = ctx[:errors].nil? ? {} : ctx[:errors]
    ctx[:errors][attr] ||= []
    ctx[:errors][attr] << error
    ctx[:errors][attr].flatten!

    # Hacky return false to route operation to :failure track
    # if step is ending on add_error
    false
  end

  def exceptions_handler(exception, ctx)
    ctx[:exception_obj] = exception
    ctx[:exception_class] = exception.class
    ctx[:exception] = exception.to_s
  end

  private

  def parse_nested_error(messages)
    messages.to_a.flatten(1)
  end
end
