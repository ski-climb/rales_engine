require './app/importers/transactions_importer'

desc 'Import transactions'
namespace :import do
  task :transactions => :environment do
    file = './db/csv/transactions.csv'
    TransactionsImporter.new(file).import
  end
end
