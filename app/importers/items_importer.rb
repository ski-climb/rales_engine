require 'csv'

class ItemsImporter
  attr_reader :filename,
              :number_of_lines

  def initialize(filename)
    @filename = filename
    @number_of_lines = `wc -l #{filename}`.to_i
  end

  def import
    bar = ProgressBar.create(title: "Items", total: number_of_lines)

    CSV.foreach(filename, headers: true) do |row|

      item_attributes = {
        id:                   row['id'].to_i,
        name:                 row['name'],
        description:          row['description'],
        unit_price_in_cents:  row['unit_price'].to_i,
        merchant_id:          row['merchant_id'].to_i,
        updated_at:           to_date(row['updated_at']),
        created_at:           to_date(row['created_at'])
      }
            
      Item.create!(item_attributes)

      bar.increment
    end
    bar.finish
    puts "#{number_of_lines} items imported"
  end

  private

  def to_date(row)
    DateTime.parse(row)
  end
end