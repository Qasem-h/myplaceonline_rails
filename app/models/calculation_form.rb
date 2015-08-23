class CalculationForm < MyplaceonlineIdentityRecord
  validates :name, presence: true
  validates :equation, presence: true
  
  has_many :calculation_inputs, :dependent => :destroy
  accepts_nested_attributes_for :calculation_inputs, allow_destroy: true, reject_if: :all_blank
  
  belongs_to :root_element, class_name: CalculationElement, autosave: true
  #validates_associated :root_element
  #validates_presence_of :root_element
  accepts_nested_attributes_for :root_element
  
  def display
    name
  end
  
  after_initialize :init

  def init
    self.is_duplicate = false if self.is_duplicate.nil?
  end
  
  validate do
    if !equation.blank?
      calc = Dentaku::Calculator.new
      dependencies = calc.dependencies(equation)
      dependencies.each do |dependency|
        found_input = calculation_inputs.find{|calculation_input| calculation_input.variable_name == dependency.to_s}
        if found_input.nil?
          errors.add(:equation, I18n.t("myplaceonline.calculation_forms.inputs_missing", variable_name: dependency.to_s))
        end
      end
      
      calculation_inputs.each do |calculation_input|
        calc.store(calculation_input.variable_name => 1)
      end
      
      calc.evaluate(equation).to_s
    end
  end
end
