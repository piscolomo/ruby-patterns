class Hero
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def join(level)
    puts "#{self.name} join #{level}\n"
  end

  def attack(enemy)
    puts "#{self.name} kick #{enemy}\n"
  end
end

class Enemy
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def dead(hero)
    puts "#{self.name} killed by #{hero}"
  end
end

class Level
  attr_reader :stage

  def initialize(stage)
    @stage = stage
  end

  def to_s
    stage
  end
end

class GameFacade
  attr_reader :hero, :enemy, :level

  def initialize
    @hero  = Hero.new('Sonic')
    @enemy = Enemy.new('Eggman')
    @level = Level.new('Green Hill')
  end

  def start_game
    hero.join(level)
    hero.attack(enemy.name)
    enemy.dead(hero.name)
  end
end

game = GameFacade.new
game.start_game
