require './app/importers/items_importer'

desc 'Import items'
namespace :import do
  task :items => :environment do
    file = './db/csv/items.csv'
    ItemsImporter.new(file).import
  end
end
