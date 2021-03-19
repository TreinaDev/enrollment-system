class Customer < ApplicationRecord

    validates :email, :name, :cpf, :birthdate, :payment_method, presence: true
    validates :token, :cpf, presence: true, uniqueness: true

    def self.generate_token
        token = self.new_token
        while !Customer.find_by(token: token).nil?
            token = self.new_token
        end
        token
    end

    def self.new_token 
        number = [*'a'..'z', *'A'..'Z', *0..9].shuffle.permutation(3)
        number.next.join
    end

end
