class Shape

    def initialize(number_of_sides=0, side_lengths)
        @number_of_sides = number_of_sides
        @side_lengths = side_lengths
    end

    def get_perimeter
        return @side_lengths.inject { |sum, x| sum + x }
    end

end

class Square < Shape

    def initialize(side_length)
        super(4, [side_length, side_length, side_length, side_length])
        @side_length = side_length
    end

    def get_area
        return @side_length*@side_length
    end
end

class Triangle < Shape

    def initialize(base, width, height)
            super(3, [base,width,height])
    end

    def get_area
        return base*height*0.5
    end
end