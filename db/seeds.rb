# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def create_client
  names = client_names_generator
  client = Client.new
  client.first_name = names[0]
  client.last_name = names[1]
  client.surname = names[2]
  client.uid = get_client_uid
  client.tag = get_tag
  client.save!
end

def client_names_generator
  l_n = ['Петров', 'Иванов','Гончаров','Мерзляков','Овсяников','Гузачев']
  f_n = ['Иван', 'Алексей', 'Александр', 'Владимир', 'Илья', 'Олег']
  s_n = ['Иванов', 'Александрович', 'Олегович', 'Владимирович', 'Петрович', 'Анатольевич']
  [f_n[rand(0..5)],l_n[rand(0..5)],s_n[rand(0..5)]]
end

def get_tag
  ["vip","manager","user","MLG_VIP"][rand(0..3)]
end

def get_client_uid
  @uid_counter = 0 if @uid_counter.nil?
  @client_uids = [] if @client_uids.nil?
  @uid_counter += 1
  @client_uids << @uid_counter
  @uid_counter
end

def get_currency
  @get_currency ||= Account::CURRENCY.dup.values.pluck(:table)
  @get_currency[rand(0..(@get_currency.size - 1))]
end

def create_account(client_uid)
  currency = get_currency
  account = Account.new
  account.client_uid = client_uid
  account.uid = @uid_counter += 1
  account.currency = currency
  account.save!
  ClientRefill.call(client_refill: client_uid, amount: 10_000, currency: currency)
end

def start_remittance
  uid_payment, uid_remittance = get_client_uids_for_remittance
  ClientRemittance.call(client_payment: uid_payment, client_refill: uid_remittance, amount: 100, currency: get_currency_for_remittance(uid_payment))
end

def get_client_uids_for_remittance
  uid_one = @client_uids[rand(0..(@client_uids.size - 1))]
  uid_two = @client_uids[rand(0..(@client_uids.size - 1))]
  if uid_one == uid_two
    uid_one, uid_two = get_client_uids_for_remittance
  end
  [uid_one, uid_two]
end

def get_currency_for_remittance(uid_payment)
  Account.find_by(client_id: Client.find_by(uid: uid_payment).id).currency
end

unless Rails.env.production?
  10.times{ create_client }
  @client_uids.each do |client_uid|
    create_account(client_uid)
  end
  100.times{ start_remittance }
end