require './app/importers/merchants_importer'

desc 'Import merchants'
namespace :import do
  task :merchants => :environment do
    file = './db/csv/merchants.csv'
    MerchantsImporter.new(file).import
  end
end
