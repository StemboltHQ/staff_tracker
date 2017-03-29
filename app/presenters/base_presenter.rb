class BasePresenter < SimpleDelegator
  attr_reader :view
  def initialize(model, view)
    @view = view
    @model = model
    super(model)
  end
end
