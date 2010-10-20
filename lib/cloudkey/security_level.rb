module Cloudkey
  class API
    module SecurityLevel  
      NONE              = 0
      DELEGATE          = 1 << 0
      ASNUM             = 1 << 1
      IP                = 1 << 2
      USERAGENT         = 1 << 3
      USEONCE           = 1 << 4
      COUNTRY           = 1 << 5
      REFERER           = 1 << 6
    end
  end
end