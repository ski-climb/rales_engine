require './app/importers/invoices_importer'

desc 'Drop and recreate database AND import all data from CSVs'
namespace :import do
  task :all => :environment do
    Rake::Task["db:schema:load"].invoke
    customers =     './db/csv/customers.csv'
    merchants =     './db/csv/merchants.csv'
    items =         './db/csv/items.csv'
    invoices =      './db/csv/invoices.csv'
    transactions =  './db/csv/transactions.csv'
    invoice_items = './db/csv/invoice_items.csv'
    puts "\n Yes, you have time to grab a cup of coffee. \n If you leave now.\n\n"
    CustomersImporter.new(customers).import
    MerchantsImporter.new(merchants).import
    ItemsImporter.new(items).import
    InvoicesImporter.new(invoices).import
    TransactionsImporter.new(transactions).import
    InvoiceItemsImporter.new(invoice_items).import
  end
end
