module UserHeaderSpecHelper
  DEFAULT_USER = {
    "entitlements" => {
      "ansible"          => {
        "is_entitled" => true
      },
      "hybrid_cloud"     => {
        "is_entitled" => true
      },
      "insights"         => {
        "is_entitled" => true
      },
      "migrations"       => {
        "is_entitled" => true
      },
      "openshift"        => {
        "is_entitled" => true
      },
      "smart_management" => {
        "is_entitled" => true
      }
    },
    "identity" => {
      "account_number" => "0369233",
      "type"           => "User",
      "user"     =>  {
        "username"     => "jdoe",
        "email"        => "jdoe@acme.com",
        "first_name"   => "John",
        "last_name"    => "Doe",
        "is_active"    => true,
        "is_org_admin" => false,
        "is_internal"  => false,
        "locale"       => "en_US"
      },
      "internal" => {
        "org_id"    => "3340851",
        "auth_type" => "basic-auth",
        "auth_time" => 6300
      }
    }
  }.freeze

  def self.default_account_number
    default_user_hash["identity"]["account_number"]
  end

  def self.default_username
    default_user_hash["identity"]["user"]["username"]
  end

  def self.encode(val)
    if val.kind_of?(Hash)
      hashed = val.stringify_keys
      Base64.strict_encode64(hashed.to_json)
    else
      raise StandardError, "Must be a Hash"
    end
  end

  def self.encoded_user_hash(hash = nil)
    encode(hash || DEFAULT_USER)
  end

  def self.default_user_hash
    Marshal.load(Marshal.dump(DEFAULT_USER))
  end

  def self.default_headers
    { 'x-rh-identity'            => encoded_user_hash,
      'x-rh-insights-request-id' => 'gobbledygook' }
  end
end