module Lib
  module Service
    class ErrorsConverter
      def self.call(errors)
        (errors || {}).map do |key, messages|
          path = ['attributes', key.to_s.camelize(:lower)]
          { path: path, messages: messages }
        end.presence ||
            [{ path: ['base'], messages: [I18n.t('errors.default')] }]
      end
    end
  end
end
