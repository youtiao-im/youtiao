module HashidsSupport
  module ClassMethods
    def id_hash
      Hashids.new("#{table_name}-#{ENV['HASHIDS_SALT']}", 8, '0123456789abcdef')
    end

    def encrypt_id(id)
      return nil if id.nil?
      id.is_a?(String) ? id : id_hash.encode(id)
    end

    def decrypt_id(id)
      return nil if id.nil?
      id.is_a?(String) ? id_hash.decode(id).first : id
    end
  end

  module InstanceMethods
    def encrypted_id
      self.class.encrypt_id(id)
    end

    def to_param
      encrypted_id
    end
  end

  def self.included(base)
    base.send :extend, ClassMethods
    base.send :include, InstanceMethods
  end
end

ActiveRecord::Base.send :include, HashidsSupport
