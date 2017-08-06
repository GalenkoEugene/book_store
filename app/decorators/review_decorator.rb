# frozen_string_literal: true

class ReviewDecorator < Draper::Decorator
  delegate_all

  def created_at
    object.created_at.strftime('%D')
  end

  def context
    object.context
  end

  def book_score
    stars = "<div class='mb-15'>" +
            "<i class='fa fa-star rate-star'></i>" * object.score +
            "<i class='fa fa-star rate-star rate-empty'></i>" * (5 - object.score) +
            '</div>'
    stars.html_safe
  end

  def user_avatar
    with_image = "<img class='img-circle logo-size inlide-block pull-left' src='#{object.user.image}'>".html_safe
    return with_image if object.user.image
    letter = object.user.email[0].upcase
    "<span class='img-circle logo-size inlide-block pull-left logo-empty'>#{letter}</span>".html_safe
  end

  def user_name
    return 'No Name' unless object.user.first_name && object.user.last_name
    object.user.last_name[0].upcase + '. ' + object.user.first_name.capitalize
  end
end
