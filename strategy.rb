class Hero
  attr_reader :damage, :health, :skills
  attr_accessor :printer

  def initialize(printer)
    @damage = 10
    @health = 5
    @printer = printer
    @skills = [:stealth, :driving, :intimidation]
  end

  def print_stats
    if block_given?
      yield(damage, health, skills)
    else
      printer.print(damage, health, skills)
    end
  end
end

class BattleStats
  def print(damage, health, skills)
    "Damage: #{damage}\nHealth: #{health}"
  end
end

class SkillStats
  def print(damage, health, skills)
    skills.inject(""){ |result, skill| result + skill.to_s.capitalize + "\n" }
  end
end

# Usage
Hero.new(BattleStats.new)
Hero.print_stats
# => Damage: 10
#    Health: 5

Hero.new(SkillStats.new)
Hero.print_stats
# => Stealth
#    Driving
#    Intimidation

Hero.new(any_printer)
Hero.print_stats do |damage, health, skills|
  "Looks: I'm printing a customize message about my hero with damage #{damage} and number of skills: #{skills.size}"
end