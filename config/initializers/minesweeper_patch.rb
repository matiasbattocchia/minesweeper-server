module Minesweeper
  module Core
    module Elements
      class Cell
        def to_s
          @current_state.class == CellState::REVEALED_STATE.class ?
            @mines_around.to_s : @current_state.to_s
        end

        def revealed?
          @current_state.class == CellState::REVEALED_STATE.class
        end

        def flagged?
          @current_state.class == CellState::FLAGGED_STATE.class
        end

      end
    end
  end
end
