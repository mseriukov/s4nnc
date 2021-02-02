import C_nnc

extension Model.Parameters {
  /**
   * Copy parameters from one model to another.
   *
   * - Parameter parameters: The parameters of another model, it must match the parameters copy to.
   */
  public func copy(from parameters: Model.Parameters) {
    guard var fromModel = parameters.model,
      var toModel = model
    else {
      fatalError()
    }
    // We can only copy parameters from fully compiled model, i.e., the owner of the sub-models.
    // Try to find them.
    while let owner = fromModel.owner {
      fromModel = owner
    }
    while let owner = toModel.owner {
      toModel = owner
    }
    ccv_cnnp_model_set_parameters(toModel._model, _io, fromModel._model, parameters._io)
  }
}

extension Model.Parameters {
  /**
   * Interpolate from current parameters to the another.
   *
   * parameters = (1 - weight) * parameters + weight * other
   *
   * - Parameter weight: How much the other parameter should weight, it must be between [0, 1].
   * - Parameter parameters: The parameters of another model, it must match the parameters to update.
   */
  public func lerp(_ weight: Float, to parameters: Model.Parameters) {
    precondition(weight >= 0 && weight <= 1)
    guard var fromModel = parameters.model,
      var toModel = model
    else {
      fatalError()
    }
    // We can only copy parameters from fully compiled model, i.e., the owner of the sub-models.
    // Try to find them.
    while let owner = fromModel.owner {
      fromModel = owner
    }
    while let owner = toModel.owner {
      toModel = owner
    }
    var params = CmdParamsFactory.factory.newParams()
    params.size.dim = (1, 1, 1, 0, 0, 0, 0, 0)
    params.blas.a = (weight, 1 - weight, 0)
    let cmd = ccv_nnc_cmd(CCV_NNC_ADD_FORWARD, nil, params, 0)
    ccv_cnnp_model_parameters_zip_map(
      toModel._model, _io, cmd, ccv_nnc_no_hint, 0, nil, fromModel._model, parameters._io)
  }
}
