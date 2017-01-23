class TaxDocumentsController < MyplaceonlineController
  def may_upload
    true
  end

  def use_bubble?
    true
  end
  
  def bubble_text(obj)
    obj.fiscal_year.to_s
  end

  protected
    def insecure
      true
    end

    def sorts
      ["tax_documents.fiscal_year DESC NULLS LAST", "lower(tax_documents.tax_document_form_name) ASC"]
    end

    def obj_params
      params.require(:tax_document).permit(
        :tax_document_form_name,
        :tax_document_description,
        :notes,
        :received_date,
        :fiscal_year,
        :amount,
        tax_document_files_attributes: FilesController.multi_param_names
      )
    end
end
