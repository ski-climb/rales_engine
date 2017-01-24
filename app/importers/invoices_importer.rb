require 'csv'

class InvoicesImporter

  attr_reader :filename,
              :number_of_lines

  def initialize(filename)
    @filename = filename
    @number_of_lines = `wc -l #{filename}`.to_i
  end

  def import
    bar = ProgressBar.create(title: "Invoices", total: number_of_lines)

    CSV.foreach(filename, headers: true) do |row|

      invoice_attributes = {
        id:          row['id'].to_i,
        customer_id: row['customer_id'].to_i,
        merchant_id: row['merchant_id'].to_i,
        status:      row['status'],
        updated_at:  to_date(row['updated_at']),
        created_at:  to_date(row['created_at'])
      }

      Invoice.create!(invoice_attributes)

      bar.increment
    end
    bar.finish
    puts "#{number_of_lines - 1} invoices imported"
  end

  private

    def to_date(string)
      DateTime.parse(string)
    end
end
