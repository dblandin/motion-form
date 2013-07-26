module MotionForm
  class Base < UITableView
    def init
      initWithFrame(frame, style: UITableViewStyleGrouped).tap do |f|
        f.register_cells

        f.dataSource = self
        f.delegate   = self
      end
    end

    def section
      MotionForm::Section.new.tap do |section|
        sections << section

        yield section
      end
    end

    def sections
      @sections ||= [ MotionForm::Section.new ]
    end

    def input(key, options = {})
      sections.first.input(key, options)
    end

    def button(key, options = {})
      sections.first.button(key, options)
    end

    def register_cells
      MotionForm.registered_cells.each do |klass|
        registerClass(klass, forCellReuseIdentifier: klass::IDENTIFIER)
      end
    end

    def numberOfSectionsInTableView(table_view)
      sections.count
    end

    def tableView(table_view, numberOfRowsInSection: section_index)
      sections[section_index].rows.count
    end

    def tableView(table_view, didSelectRowAtIndexPath: index_path)
      section = sections[index_path.section]
      row     = section.rows[index_path.row]
    end

    def rows
      sections.map(&:rows).flatten
    end

    def tableView(table_view, cellForRowAtIndexPath: index_path)
      section = sections[index_path.section]
      row     = section.rows[index_path.row]

      table_view.dequeueReusableCellWithIdentifier(row.cell_identifier).tap do |cell|
        row.update_cell(cell)
      end
    end

    def render
      Hash[render_values]
    end

    def render_values
      value_rows.map { |row| [row.key, row.value] }
    end

    def value_rows
      rows.select { |row| row.has_value? }
    end
  end
end
