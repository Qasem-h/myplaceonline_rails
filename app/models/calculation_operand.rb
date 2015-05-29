class CalculationOperand < ActiveRecord::Base
  belongs_to :identity

  # Recursive operand
  belongs_to :calculation_element
  accepts_nested_attributes_for :calculation_element, reject_if: :all_blank
  
  belongs_to :calculation_input
  accepts_nested_attributes_for :calculation_input, reject_if: :all_blank
  
  # constant_value:string
  
  validate do
    if blank?
      errors.add(:base, I18n.t("myplaceonline.calculation_forms.operand_blank"))
    end
  end
  
  def blank?
    constant_value.blank? && calculation_element.nil?
  end
  
  def to_human_readable
    calculation_element.nil? ? constant_value : calculation_element.to_human_readable
  end
  
  before_create :do_before_save
  before_update :do_before_save

  def do_before_save
    Myp.set_common_model_properties(self)
  end
end
