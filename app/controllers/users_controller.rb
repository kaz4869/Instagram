class UsersController < ApplicationController
    before_action :authenticate_user!, :only => [:show]
    def show
        @user = User.find(params[:id])
        @currentUserEntry=Entry.where(user_id: current_user.id)
        @userEntry=Entry.where(user_id: @user.id)
        if @user.id == current_user.id
        else
            @currentUserEntry.each do |cu|
                @userEntry.each do |u|
                    if cu.room_id == u.room_id then
                        @isRoom = true
                        @roomId = cu.room_id
                    end
                end
            end
            if @isRoom
            else
                @room = Room.new
                @entry = Entry.new
            end
        end
        @following_array = Array.new
        @followingUserEntry = Array.new
        @user.followings.each do |following|
            @followingUserEntry=Entry.where(user_id: following.id)
            if following.id == current_user.id
                @following_array[following.id] = { "isRoom" => "me", "roomId" => "" }
            else
                @currentUserEntry.each do |cu|
                    @followingUserEntry.each do |fu|
                        if fu.room_id == cu.room_id then
                            @following_array[following.id] = { "isRoom" => "true", "roomId" => fu.room_id }
                        end
                    end
                end
            end
        end
        @user.followings.each do |following|
            if @following_array[following.id]
            else
                @following_array[following.id] = { "isRoom" => "false", "roomId" => following.name }
                @room = Room.new
                @entry = Entry.new
            end
        end
        @follower_array = Array.new
        @followerUserEntry = Array.new
        @user.followers.each do |follower|
            @followerUserEntry=Entry.where(user_id: follower.id)
            if follower.id == current_user.id
                @follower_array[follower.id] = { "isRoom" => "me", "roomId" => "" }
            else
                @currentUserEntry.each do |cu|
                    @followerUserEntry.each do |fu|
                        if fu.room_id == cu.room_id then
                            @follower_array[follower.id] = { "isRoom" => "true", "roomId" => fu.room_id }
                        end
                    end
                end
            end
        end
        @user.followers.each do |follower|
            if @follower_array[follower.id]
            else
                @follower_array[follower.id] = { "isRoom" => "false", "roomId" => "" }
                @room = Room.new
                @entry = Entry.new
            end
        end
    end
end
