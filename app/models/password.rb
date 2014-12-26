class Password < ActiveRecord::Base
  include EncryptedConcern
  belongs_to :identity
  belongs_to :password_encrypted,
      class_name: EncryptedValue, dependent: :destroy, :autosave => true
  belongs_to_encrypted :password
  has_many :password_secrets, :dependent => :destroy
  accepts_nested_attributes_for :password_secrets, allow_destroy: true
  
  validates :name, presence: true
  
  def get_url(prefertls = true)
    result = url
    if !result.to_s.empty?
      if prefertls && result.start_with?("http:")
        result = "https" + result[4..-1]
      end
      
      if (/^[^:]+:.*/ =~ result).nil?
        result = (prefertls ? "https://" : "http://") + result
      end
    end
    result
  end
  
  def display
    result = name
    if !user.to_s.empty?
      result += " (" + user + ")"
    end
    result
  end
  
  def as_json(options={})
    if password_encrypted?
      options[:except] ||= "password"
    end
    super.as_json(options).merge({
      :password_secrets => password_secrets.to_a.map{|x| x.as_json}
    })
  end
end
