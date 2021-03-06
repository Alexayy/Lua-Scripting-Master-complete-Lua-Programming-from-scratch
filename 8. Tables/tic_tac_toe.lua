---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by acakic.
--- DateTime: 7.12.20. 07:40
---

-- TODO: Finish this later

-------------------------------------------------------------
--- Create new table to hold the board
-------------------------------------------------------------
local board = { }

-------------------------------------------------------------
--- Clear the board table
-------------------------------------------------------------
function clear_board()
    for i = 1, 3 do
        -- new row
        board[i] = {}

        for j = 1, 3 do
            board[i][j] = " "
        end
    end
end

-------------------------------------------------------------
--- Display the board table
-------------------------------------------------------------
function display_board()
    -- TODO:
    -- Loop all the positions on the board
    -- and display the values in the console
    print("   1  2  3 ")
    for i = 1, 3 do
        print(i .. " ["..board[i][1].."]["..board[i][2].."]["..board[i][3].."]")
    end
end

-------------------------------------------------------------
--- Is board full?
-------------------------------------------------------------
function display_full()
    -- TODO:
    -- Loop all the positions on the board
    -- and check if they are all populated
    -- returning true (full) or false (not full)
    for i = 1, 3 do
        for j = 1, 3 do
            if board[i][j] == " " then
                return false
            end
        end
    end
    return true
end

-------------------------------------------------------------
--- Function to check and return the winner
-------------------------------------------------------------
function check_winner()
    -- TODO:
    -- Check all rows, columns and diagonals
    -- to see if there is a winner
    -- if there is one, return "X" or "O"
    -- check rows
    if board[1][1] ~= " " and board[1][1] == board[1][2] and board[1][2] == board[1][3] then return board[1][1] end
    if board[2][1] ~= " " and board[2][1] == board[2][2] and board[2][2] == board[2][3] then return board[2][1] end
    if board[3][1] ~= " " and board[3][1] == board[3][2] and board[3][2] == board[3][3] then return board[3][1] end

    -- check cols
    if board[1][1] ~= " " and board[1][1] == board[2][1] and board[2][1] == board[3][1] then return board[1][1] end
    if board[1][2] ~= " " and board[1][2] == board[2][2] and board[2][2] == board[3][2] then return board[1][2] end
    if board[1][3] ~= " " and board[1][3] == board[2][3] and board[2][3] == board[3][3] then return board[1][3] end

    -- check diagonals
    if board[1][1] ~= " " and board[1][1] == board[2][2] and board[2][2] == board[3][3] then return board[1][1] end
    if board[1][3] ~= " " and board[1][3] == board[2][2] and board[2][2] == board[3][1] then return board[1][3] end

    -- if there is no winner
    return nil
end

-------------------------------------------------------------
--- Game starts
-------------------------------------------------------------
local player = "X"
local move = 1
local game_over = false

clear_board()

-- Game loop
while not game_over do
    display_board()

    print("Enter the row you want to place the symbol "..player..": ")
    local row_to_play = io.read("*n")
    print("Enter the col you want to place the symbol "..player..": ")
    local col_to_play = io.read("*n")

    -- prevent the user to select a position that is already taken
    if board[row_to_play][col_to_play] ~= " " then
        print("Invalid! Please select an empty position.")
    else
        board[row_to_play][col_to_play] = player

        -- the current player if based on odd/even move
        if move % 2 == 0 then
            player = "X"
        else
            player = "O"
        end

        move = move + 1

        -- check if there is a winner
        local winner = check_winner()

        if winner ~= nil then
            display_board()
            print("Game Over! The winner is "..winner)
            game_over = true
        elseif display_full() then
            print("Game Over! Tie.")
            game_over = true
        end
    end
end