# -------------------------------------------------------------------------- #
# Copyright 2002-2017, OpenNebula Project, OpenNebula Systems                #
#                                                                            #
# Licensed under the Apache License, Version 2.0 (the "License"); you may    #
# not use this file except in compliance with the License. You may obtain    #
# a copy of the License at                                                   #
#                                                                            #
# http://www.apache.org/licenses/LICENSE-2.0                                 #
#                                                                            #
# Unless required by applicable law or agreed to in writing, software        #
# distributed under the License is distributed on an "AS IS" BASIS,          #
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   #
# See the License for the specific language governing permissions and        #
# limitations under the License.                                             #
#--------------------------------------------------------------------------- #

module OpenNebula
    # we use this file to extend opennebula oca functionalities
    # It contains generic methods that can be used in oca context
    # to help other components

    # receive a object key => value format
    # returns hashed values
    def self.encrypt(opts, token)
        res = {}
        opts.each do |key, value|
            cipher = OpenSSL::Cipher::AES.new(256,:CBC)
            cipher.encrypt.key = token[0..31]
            encrypted = cipher.update(value) + cipher.final
            res[key] = Base64::encode64(encrypted).gsub("\n", "")
        end
        return res
    end

end