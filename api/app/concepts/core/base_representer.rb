class Core::BaseRepresenter < Roar::Decorator
  require 'roar/json'
  include Roar::JSON

  defaults render_nil: true
end
