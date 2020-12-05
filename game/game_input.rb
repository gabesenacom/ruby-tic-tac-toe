# frozen_string_literal: false

# It captures user input
module GameInput
  def request(force, empty_callback = nil, accept_only = [], transform = nil)
    response = gets.chomp

    return reload_request(force, empty_callback, accept_only, transform) while response.empty? && force

    response = transform.call(response) unless transform.nil?

    if !accept_only.empty? && !accept_only.include?(response)
      return reload_request(force, empty_callback, accept_only, transform)
    end

    response
  end

  def reload_request(force, empty_callback = nil, accept_only = [], transform = nil)
    empty_callback&.call
    request(force, empty_callback, accept_only, transform)
  end
end
