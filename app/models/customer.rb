class Customer < ApplicationRecord

    def self.generate_token
        number = [*'a'..'z', *'A'..'Z', *0..9].shuffle.permutation(3)
        token = number.next.join
        unless Customer.find_by(token: token).nil?
            self.generate_token
        else
            token
        end
    end
end
