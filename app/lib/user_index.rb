class UserIndex < Chewy::Index
  settings analysis: {
    filter: {
      edge_ngram_filter: {
        type: "edge_ngram",
        min_gram: 1,
        max_gram: 10
      }
    },
    analyzer: {
      default: {
        type: "custom",
        tokenizer: "standard",
        filter: [
          "lowercase",
          "asciifolding",
          "edge_ngram_filter"
        ]
      },
      default_search: {
        type: "custom",
        tokenizer: "whitespace",
        filter: [
          "lowercase",
          "asciifolding"
        ]
      }
    }
  }
  
  @indices = {}
  
  Myp.process_models do |klass|
    string_columns = []
    integer_columns = []
    klass.columns.each do |column|
      if column.type == :string || column.type == :text
        if klass.instance_methods.index("#{column.name}_encrypted?".to_sym).nil?
          string_columns.push(column)
        end
      elsif column.type == :integer && column.name.index("_id").nil?
        integer_columns.push(column)
      elsif column.type != :integer && column.type != :datetime && column.type != :date && column.type != :boolean && column.type != :decimal && column.type != :binary && column.type != :inet
        # TODO enforce https://www.elastic.co/blog/great-mapping-refactoring
      end
    end
    
    # Only create a type if it has some text fields
    if string_columns.length > 0
      
      Rails.logger.debug{"UserIndex Creating type for: #{klass.name}"}
      
      defined_type = define_type klass do

        # https://www.elastic.co/guide/en/elasticsearch/reference/current/string.html
        #field :allstrings
        
        string_columns.each do |column|
          field column.name.to_sym
        end
        
        # https://www.elastic.co/guide/en/elasticsearch/reference/current/number.html
        field :identity_id, type: "integer", include_in_all: false
        
        integer_columns.each do |column|
          field column.name.to_sym, type: "integer", include_in_all: false
        end
      end
      
      @indices[klass.name] = defined_type
      
      klass.update_index("user#" + klass.name.underscore.downcase, :self)
    else
      Rails.logger.debug{"UserIndex Skipping #{klass.name}"}
    end
  end
  
  Rails.logger.debug{"UserIndex indices=#{@indices.keys.sort.join(", ")}"}
end
