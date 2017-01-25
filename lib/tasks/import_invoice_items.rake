require './app/importers/invoice_items_importer'

desc 'Import invoice items'
namespace :import do
  task :invoice_items => :environment do
    file = './db/csv/invoice_items.csv'
    InvoiceItemsImporter.new(file).import
  end
end
