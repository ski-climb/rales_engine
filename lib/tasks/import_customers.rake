require './app/importers/customers_importer'

desc 'Import customers'
namespace :import do
  task :customers => :environment do
    file = './db/csv/customers.csv'
    CustomersImporter.new(file).import
    puts "#{Customer.count} customers imported"
  end
end
