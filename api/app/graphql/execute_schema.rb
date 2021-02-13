class ExecuteSchema < Trailblazer::Operation

  pass :variables!
  pass :query!
  pass :operation_name!
  pass :context!
  pass :model!

  def variables!(ctx, params:, **)
    ctx[:variables] = Lib::Service::EnsureHash.call(params[:variables])
  end

  def query!(ctx, params:, **)
    ctx[:query] = params[:query]
  end

  def operation_name!(ctx, params:, **)
    ctx[:operation_name] = params[:operation_name]
  end

  def context!(ctx, **)
    ctx[:context] = {
      current_user: ctx[:current_user]
    }
  end

  def model!(ctx, variables:, query:, context:, **)
    ctx[:model] = ApiSchema.execute(
      query,
      variables: variables,
      context: context,
      operation_name: ctx[:operation_name]
    )
  end
end

