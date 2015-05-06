# ruby-patterns
Examples of Patterns in Ruby

## Table of Contents

  1. [Adapter](#adapter)
  1. [Builder](#builder)
  1. [Command](#command)
  1. [Composite](#composite)
  1. [Decorator](#decorator)
  1. [Factory](#factory)
  1. [Iterator](#iterator)
  1. [Observer](#observer)
  1. [Proxy](#proxy)
  1. [Singleton](#singleton)
  1. [Strategy](#strategy)
  1. [Template](#template)

## Adapter
  - Convert the interface of a class into another interface clients expect. Adapter lets classes work together that couldn't otherwise because of incompatible interfaces

  ```ruby
  class Quest
    attr_accessor :difficulty, :hero
    
    def initialize(difficulty)
      @difficulty = difficulty
      @hero = nil 
    end

    def finish
      @hero.exp += calculate_experience
    end

    def calculate_experience
      @difficulty * 50 / @hero.level
    end
  end

  class Hero
    attr_accessor :level, :exp, :quests

    def initialize
      @level = 1
      @exp = 0
      @quests = []
    end

    def take_quest(quest)
      @quests << (quest.hero = self)
    end

    def finish_quest(quest)
      quest.finish
      @quests.delete quest
    end
  end

  class OldQuest
    attr_accessor :hero, :difficulty, :experience

    def initialize
      @difficulty = 3
      @experience = 10
    end

    def done
      difficulty * experience
    end
  end

  class QuestAdapter
    attr_accessor :hero

    def initialize(old_quest, difficulty)
      @old_quest = old_quest
      @old_quest.difficulty = difficulty
      @hero = nil
    end

    def finish
      @hero.exp += @old_quest.done
    end
  end

  # Usage
  hero = Hero.new
  quest = Quest.new 5
  hero.take_quest quest
  hero.finish_quest quest
  puts hero.exp
  # => 250
  some_old_quest = OldQuest.new
  old_quest_adapted = QuestAdapter.new(some_old_quest, 5)
  hero.take_quest old_quest_adapted
  hero.finish_quest old_quest_adapted
  puts hero.exp
  # => 300
  ```