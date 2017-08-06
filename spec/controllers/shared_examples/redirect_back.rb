# frozen_string_literal: true

shared_examples_for 'redirect_back' do
  it 'redirect to the same page where you come from' do
    from book_path(book_id)
    post :create, params: { review: review_params }
    expect(response).to redirect_to book_url(book_id)
  end
end
