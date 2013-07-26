module MotionForm
  class Base < UITableView
    def init
      initWithFrame(frame, style: UITableViewStyleGrouped).tap do |f|
        f.register_cells

        f.dataSource = self
        f.delegate   = self
      end
    end

    def input(name, options = {})
      name = name.to_s.gsub('_', ' ').titleize

      rows << TextFieldRow.new(name, options)
    end

    def button(name, options = {})
      name = name.to_s.gsub('_', ' ').titleize

      rows << ButtonRow.new(name, options)
    end

    def rows
      @_rows ||= []
    end

    def register_cells
      registerClass(TextFieldCell, forCellReuseIdentifier: TextFieldCell::IDENTIFIER)
      registerClass(ButtonCell, forCellReuseIdentifier: ButtonCell::IDENTIFIER)
    end

    def numberOfSectionsInTableView(table_view)
      1
    end

    def tableView(table_view, numberOfRowsInSection: section)
      rows.count
    end

    def tableView(table_view, cellForRowAtIndexPath: index_path)
      row = rows[index_path.row]

      table_view.dequeueReusableCellWithIdentifier(row.cell_identifier).tap do |cell|
        cell.label = row.name
        cell.icon  = row.icon
        cell.accessory = row.accessory if cell.is_a? ButtonCell

        row.cell = cell unless cell.is_a? ButtonCell
      end
    end

    def render
      'rendering'
    end
  end
end
