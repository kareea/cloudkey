module Cloudkey
  class API
    module SecurityLevel
      NONE              = 0
      DELEGATE          = 1 << 0
      AS_NUMBER         = 1 << 1
      IP                = 1 << 2
      USER_AGENT        = 1 << 3
      USE_ONCE          = 1 << 4
      COUNTRIES         = 1 << 5
      REFERERS           = 1 << 6
    end
  end
end