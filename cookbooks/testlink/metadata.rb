name               "testlink"
maintainer         "Rapid7, Inc."
license            "BSD"
description        "Installs/Configures TestLink"
version            "0.1.0"

%w{ debian ubuntu }.each do |os|
  supports os
end
