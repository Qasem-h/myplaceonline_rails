class PasswordSecret < MyplaceonlineIdentityRecord
  include EncryptedConcern

  belongs_to :password
  belongs_to :answer_encrypted,
      class_name: EncryptedValue, dependent: :destroy, :autosave => true
  belongs_to_encrypted :answer

  def as_json(options={})
    if answer_encrypted?
      options[:except] ||= "answer"
    end
    super.as_json(options)
  end
end
