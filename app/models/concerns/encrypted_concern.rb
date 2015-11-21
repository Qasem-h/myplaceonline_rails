module EncryptedConcern extend ActiveSupport::Concern
  module ClassMethods
    protected
      def belongs_to_encrypted(name)
        
        if !respond_to?(:encrypt)
          define_method("encrypt") do
            if @encrypt.nil?
              @encrypt = send("#{name}_encrypted?")
            end
            @encrypt
          end
          
          define_method("encrypt=") do |newvalue|
            @encrypt = newvalue
          end
        end
        
        define_method("#{name}_encrypted?") do
          !send("#{name}_encrypted").nil?
        end
        
        define_method(name) do
          if !send("#{name}_encrypted?")
            result = super()
          else
            result = Myp.decrypt_from_session(
              ApplicationController.current_session,
              send("#{name}_encrypted")
            )
          end
          result
        end
        
        define_method("#{name}_finalize") do |encrypt = false|
          if self.send("#{name}_changed?")
            do_encrypt = encrypt || self[:encrypt] == true || (self.respond_to?("encrypt") && (self.encrypt == "1" || self.encrypt == true))
            if do_encrypt
              new_encrypted_value = Myp.encrypt_from_session(
                User.current_user,
                ApplicationController.current_session,
                self[name]
              )
              self.send("#{name}=", nil)
              if send("#{name}_encrypted?")
                Myp.copy_encrypted_value_attributes(
                  new_encrypted_value,
                  self.send("#{name}_encrypted")
                )
              else
                self.send("#{name}_encrypted=", new_encrypted_value)
              end
            else
              if send("#{name}_encrypted?")
                self.send("#{name}_encrypted").destroy!
                self.send("#{name}_encrypted=", nil)
              end
            end
          end
        end
      end
  end
end
