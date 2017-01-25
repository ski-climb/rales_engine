require 'csv'

class InvoiceItemsImporter

  attr_reader :filename,
              :number_of_lines

  def initialize(filename)
    @filename = filename
    @number_of_lines = `wc -l #{filename}`.to_i
  end

  def import
    bar = ProgressBar.create(title: "Invoice items", total: number_of_lines)

    CSV.foreach(filename, headers: true) do |row|

      invoice_item_attributes = {
        id:                  row['id'].to_i,
        quantity:            row['quantity'].to_i,
        unit_price_in_cents: row['unit_price'].to_i,
        invoice_id:          row['invoice_id'].to_i,
        item_id:             row['item_id'].to_i,
        updated_at:  to_date(row['updated_at']),
        created_at:  to_date(row['created_at'])
      }

      InvoiceItem.create!(invoice_item_attributes)

      bar.increment
    end
    bar.finish
    puts "#{number_of_lines - 1} invoice items imported"
  end

  private

    def to_date(string)
      DateTime.parse(string)
    end
end
