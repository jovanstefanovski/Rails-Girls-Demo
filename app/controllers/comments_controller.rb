class CommentsController < ApplicationController
    before_action :set_comment, only: [:edit, :update, :destroy]

    # GET /comments/1/edit
    def edit
      authorize @comment
    end

    # POST /comments
    # POST /comments.json
    def create
      authorize Comment
      @comment = Comment.new(comment_params)
      @comment.user = current_user

      respond_to do |format|
        if @comment.save
          format.html { redirect_to @comment.idea, notice: 'Comment was successfully created.' }
          format.json { render :show, status: :created, location: @comment }
        else
          format.html { redirect_to @comment.idea, alert: 'Comment was not successfully created.' }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /comments/1
    # PATCH/PUT /comments/1.json
    def update
      authorize @comment
      respond_to do |format|
        if @comment.update(comment_params)
          format.html { redirect_to @comment.idea, notice: 'Comment was successfully updated.' }
          format.json { render :show, status: :ok, location: @comment }
        else
          format.html { redirect_to @comment.idea, alert: 'Comment was not successfully updated.' }
          format.json { render json: @comment.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /comments/1
    # DELETE /comments/1.json
    def destroy
      authorize @comment
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to @comment.idea, notice: 'Comment was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_comment
        @comment = Comment.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def comment_params
        params.require(:comment).permit(:body, :idea_id)
      end
end
