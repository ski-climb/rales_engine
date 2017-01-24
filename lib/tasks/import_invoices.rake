require './app/importers/invoices_importer'

desc 'Import invoices'
namespace :import do
  task :invoices => :environment do
    file = './db/csv/invoices.csv'
    InvoicesImporter.new(file).import
  end
end
