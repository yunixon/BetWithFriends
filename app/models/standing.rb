class Standing < ActiveRecord::Base

	# associations
	belongs_to :team
	default_scope {includes(:team).references(:team)}
	validates :team, presence: true

	belongs_to :group
	validates :group, presence: true


	# validation
	validates :played, :won, :draw, :lost, :goals_for, :goals_against, :points, numericality: { greater_than_or_equal_to: 0 }

	# compute standings
	def compute_and_update

    self.played = 0
    self.won = 0
    self.draw = 0
    self.lost = 0
    self.goals_against = 0
    self.goals_for = 0
    self.points = 0

    matches = Match.where("(team_a_id = ? or team_b_id = ?) and results.played = 't'", self.team_id, self.team_id)

    matches.each do |match|

      self.played += 1

      # team_a
      if match.team_a_id == self.team_id
        self.goals_for += match.result.score_team_a
        self.goals_against += match.result.score_team_b
        if match.result.score_team_a > match.result.score_team_b
          self.won += 1
          self.points += 3
        elsif match.result.score_team_a == match.result.score_team_b
          self.draw += 1
          self.points += 1
        else
          self.lost += 1
        end
      # team_b
      else
        self.goals_for += match.result.score_team_b
        self.goals_against += match.result.score_team_a
        if match.result.score_team_a > match.result.score_team_b
          self.lost += 1
        elsif match.result.score_team_a == match.result.score_team_b
          self.draw += 1
          self.points += 1
        else
          self.won += 1
          self.points += 3
        end
      end
    end

    if self.save
      logger.debug "standing saved #{self.inspect}"
    else
      logger.error "error saving standing #{self.inspect}"
    end
	end

end
