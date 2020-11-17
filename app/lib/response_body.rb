class ResponseBody

  def response_json(success, message, error_fields = nil)
    attributes = {
        success: success,
        message: message
    }
    if error_fields
      attributes[:errorFields] = error_fields
    end
    attributes
  end

end