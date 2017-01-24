require 'csv'

class MerchantsImporter
  attr_reader :filename,
              :number_of_lines

  def initialize(filename)
    @filename = filename
    @number_of_lines = `wc -l #{filename}`.to_i
  end

  def import
    bar = ProgressBar.create(title: "Merchants", total: number_of_lines)

    CSV.foreach(filename, headers: true) do |row|

      merchant_attributes = {
        id:         row['id'].to_i,
        name:       row['name'],
        updated_at: to_date(row['updated_at']),
        created_at: to_date(row['created_at'])
      }
            
      Merchant.create!(merchant_attributes)

      bar.increment
    end
    bar.finish
    puts "#{number_of_lines - 1} merchants imported"
  end

  private

  def to_date(row)
    DateTime.parse(row)
  end
end
