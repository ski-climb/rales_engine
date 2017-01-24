require 'csv'

class TransactionsImporter
  attr_reader :filename,
              :number_of_lines

  def initialize(filename)
    @filename = filename
    @number_of_lines = `wc -l #{filename}`.to_i
  end

  def import
    bar = ProgressBar.create(title: "Transactions", total: number_of_lines)

    CSV.foreach(filename, headers: true) do |row|

      transaction_attributes = {
        id:                 row['id'].to_i,
        credit_card_number: row['credit_card_number'],
        invoice_id:         row['invoice_id'].to_i,
        result:             row['result'],
        updated_at:         to_date(row['updated_at']),
        created_at:         to_date(row['created_at'])
      }
            
      Transaction.create!(transaction_attributes)

      bar.increment
    end
    bar.finish
    puts "#{number_of_lines} transactions imported"
  end

  private

  def to_date(row)
    DateTime.parse(row)
  end
end
