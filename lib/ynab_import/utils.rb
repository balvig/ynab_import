module YnabImport
  class Utils
    def self.array_to_csv(array)
      array.map(&:to_csv).join
    end
  end
end
