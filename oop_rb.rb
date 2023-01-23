# This module is added to provide mixin since ruby dosen't support multiple inheritance...
module Gear
  @@gear = 0
  def self.neutral
    p "neutral ..."
  end
  
  def self.shift
    if @@gear == 4
      @@gear=4
      p "4th gear loaded . . ."
    else
      @@gear+=1
      p "gear #{@@gear} loaded . . .  "
    end
  end

  def self.unshift
    if @@gear == 1
      @@gear = 0
    else
      @@gear-=1
      p "gear #{@@gear} loaded . . .  "
    end
  end

end

#Base class...
class Vehicle
#Module is included
include Gear

  @@vin_arr = []

  attr_reader :year, :type, :mode_of_transmission, :fuel_type
  attr_accessor :color, :cost, :max_speed, :mileage, :speed, :cur_speed, :tank_capacity, :fuel_quantity

  def initialize(color, year, cost, max_speed, mileage, type, mode_of_transmission, fuel_type, tank_capacity)
    words = [color, type, mode_of_transmission, fuel_type]
    numbers = [year, cost, max_speed, mileage]

    #checking the arguement type...

    words.each do |word|
      raise "arguement #{word} is invalid, try using a word." unless word.is_a? String
    end

    numbers.each do |number|
      raise "arguement #{number} is invalid, try using a number." unless number.is_a? Integer
    end

    @color = color
    @year = year
    @cost = cost
    @max_speed = max_speed
    @mileage = mileage
    @type = type
    @mode_of_transmission = mode_of_transmission
    @speed = 0
    @fuel_type = fuel_type
    @fuel_quantity = 0
    @tank_capacity = tank_capacity

  end

  def start
    p "vehicle's started"
  end

  def accelerate(increase)

    raise "arguement given must be a number greater than 0" unless increase.is_a? Integer and increase>0

    cur_speed = speed
    if speed == 0
      Gear.neutral
      while speed<(cur_speed+increase)
        self.speed+=1
        if speed==1 or speed==10 or speed==20 or speed==30
          Gear.shift
        end
        p "accelerating . . . #{speed}"
        if speed>=max_speed
          p "max-speed reached . . ."
          break
        end
      end
    else
      while speed<(cur_speed+increase)
        self.speed+=1
        if speed==1 or speed==10 or speed==20 or speed==30
          Gear.shift
        end
        p "accelerating . . . #{speed}"
        if speed>=max_speed
          p "max-speed reached . . ."
          break
        end
      end
    end
  end

  def decelerate(decrease)

    raise "arguement given must be a number greater than 0" unless decrease.is_a? Integer and decrease>0

    cur_speed = speed

    if (cur_speed - decrease)>=0
      target = cur_speed - decrease
    else
      target = 0
    end

    if target>0
      while speed>target
        self.speed-=1
        if speed==30 or speed==20 or speed==10 or speed==1
          Gear.unshift
        end
        p "decelerating . . . #{speed}"
      end
      if speed==0
        Gear.neutral
      end
    else
      if speed>0
        while speed>0
          self.speed-=1
          if speed==30 or speed==20 or speed==10 or speed==1
            Gear.unshift
          end
          p "decelerating . . . #{speed}"
        end
        if speed==0
          Gear.neutral
        end
      else
        speed = 0
        if speed==0
          Gear.neutral
        end
      end

    end
  end

  def turn(direction)
    raise "direction should be either right or left" unless direction.is_a? String and direction == "right" or direction == "left"
    if direction == "right"
      p "vehicle is turning right"
    else
      p "vehicle is turning left"
    end
  end

  def brake
    p "vehicle is slowing down...halt"
  end

  def stop
    p "vehicle stopped"
  end

  def fill_fuel(quantity)
    raise "quantity must be a number greater than 0" unless quantity.is_a? Integer and quantity>0

    current_fuel = fuel_quantity
    target = current_fuel+quantity
    if target<=tank_capacity
      while fuel_quantity<target
        self.fuel_quantity+=1
        if fuel_quantity==tank_capacity
          p "full-tank"
        else
          p "fuel : #{fuel_quantity}"
        end
      end
    else
      while fuel_quantity<tank_capacity
        self.fuel_quantity+=1
        if fuel_quantity==tank_capacity
          p "full-tank"
        else
          p "fuel : #{fuel_quantity}"
        end
      end
    end
  end

  def vehicle_info
    p <<-INFO
    The vehicles's color is : #{color}
    This is launched in the year #{year}
    The price of the vehicle is #{cost}
    The max-speed for this vehicle is #{max_speed}
    Mileage of the vehicle is #{mileage}
    It is of #{type} type
    The vehicle supports #{mode_of_transmission}
    It use #{fuel_type} for fuel.
    The tank capaicity for this vehicle is #{tank_capacity}
    INFO
  end

end

=begin
vehicle = Vehicle.new("red", 2010, 20, 100, 40, "general", "land", "diesel", 10)
vehicle.start
vehicle.accelerate(10)
vehicle.decelerate(2)
vehicle.accelerate(3)
vehicle.decelerate(1)
=end
#Inheriting Car class from vehicle
class Car < Vehicle
  attr_reader :no_of_wheels, :no_of_doors
  attr_accessor :capacity
  def initialize(color, year, cost, max_speed, mileage, type, mode_of_transmission, fuel_type, tank_capacity, no_of_wheels, no_of_doors, capacity)
    super color, year, cost, max_speed, mileage, type, mode_of_transmission, fuel_type, tank_capacity

    numb_arr = [no_of_doors, no_of_wheels, capacity]
    numb_arr.each do |numb|
      raise "arguement #{numb} is invalid, try using a number." unless numb.is_a? Integer
    end

    @no_of_wheels = no_of_wheels
    @no_of_doors = no_of_doors
    @capacity = capacity
  end

  def start
    p "Car's started"
  end

  def turn(direction)
    raise "direction should be either right or left" unless direction.is_a? String and direction == "right" or direction == "left"
    if direction == "right"
      p "car is turning right"
    else
      p "car is turning left"
    end
  end

  def stop
    p "car stopped"
  end

  def brake
    p "car is slowing down...halt"
  end

  def horn
    p "car honks"
  end

  def light_control(toggle)
    raise "the toggle has to be either on or off" unless toggle=="on" or toggle=="off"
    if toggle == "on"
      p "lights turned on"
    else
      p "lights turned off"
    end
  end

  def windows_control(direction)
    raise "the direction has to be either up or down" unless direction=="up" or direction=="down"
    if direction == "up"
      p "windows closed"
    else
      p "windows opened"
    end
  end

  def car_info
    p <<-INFO
    The car's color is : #{color}
    This is launched in the year #{year}
    The price of the car is #{cost}
    The max-speed for this car is #{max_speed}
    Mileage of the car is #{mileage}
    It is of #{type} type
    The car supports #{mode_of_transmission}
    It use #{fuel_type} for fuel.
    The tank capaicity for this car is #{tank_capacity}
    number of wheels for this car is #{no_of_wheels}
    number of doors for this car is #{no_of_doors}
    capacity for this car is 4
    INFO
  end

end
#Inheriting Suzuki from Car
class Suzuki < Car

  attr_reader :vin

  def initialize(color, year, cost, max_speed, mileage, type, mode_of_transmission, fuel_type, tank_capacity, no_of_wheels, no_of_doors, capacity, vin)
    super color, year, cost, max_speed, mileage, type, mode_of_transmission, fuel_type, tank_capacity, no_of_wheels, no_of_doors, capacity

    raise "arguement #{vin} is invalid, try using an unique number greater than 0." unless (vin.is_a? Integer) and !(@@vin_arr.include? vin) and vin>0
    @@vin_arr << vin

    @vin = vin

  end

  def what_is_my_vin
    p "VIN for your car is #{vin}."
  end

end
    



suzu = Suzuki.new("red", 2010, 20, 100, 40, "general", "land", "diesel", 10000, 4, 4, 4, 1)
suzu.what_is_my_vin