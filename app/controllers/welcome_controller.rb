class WelcomeController < ApplicationController
  def index
  end
  def about
  end
  def creator
  end
  def search
    if @json_resp != nil && @json_resp
      hits = @json_resp["hits"]
      hits.each do |h|
        r =  h["recipe"]
        if params["search"].present? && !params["search"].empty?
          if r["healthLabels"].to_sentence.downcase.include?(params["search"].downcase) || r["dietLabels"].to_sentence.downcase.include?(params["search"].downcase) || r["label"].downcase.include?(params["search"].downcase)
            downcasedHealthLabels = r["healthLabels"].map(&:downcase)
            if downcasedHealthLabels.include?(@user.preference.healthlabel[0].apiparameter.downcase) || @specialcase
              if @foundItems.include?(r)
                next
              end
              @foundItems.push(r)
            end
          end
        else
          downcasedHealthLabels = r["healthLabels"].map(&:downcase)
          if downcasedHealthLabels.include?(@user.preference.healthlabel[0].apiparameter.downcase) || @specialcase
            if @foundItems.include?(r)
              next
            end
            @foundItems.push(r)
          end
        end
      end
      return @foundItems.length
    else
      return 0
    end

  end
end
