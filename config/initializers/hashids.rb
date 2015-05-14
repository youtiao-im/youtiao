# module HashidsSupport
#   module ClassMethods
#     def id_hash
#       Hashids.new("#{table_name}-y0u7140", 8)
#     end

#     def encrypt_id(id)
#       id.is_a?(String) ? id : id_hash.encode(id)
#     end

#     def decrypt_id(id)
#       id.is_a?(String) ? id_hash.decode(id).first : id
#     end

#     def find(*args)
#       scope = args.slice!(0)
#       if scope.is_a?(Array)
#         scope.map! { |id| decrypt_id(id).to_i }
#       else
#         scope = decrypt_id(scope)
#       end
#       super(scope)
#     end
#   end

#   module InstanceMethods
#     def encrypted_id
#       self.class.encrypt_id(id)
#     end

#     def to_param
#       encrypted_id
#     end
#   end

#   def self.included(base)
#     base.extend ClassMethods
#     base.include InstanceMethods
#   end
# end

# ActiveRecord::Base.send :include, HashidsSupport
