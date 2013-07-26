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
      end
    end

    def sections
      @sections ||= [MotionForm::Section.new]
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

    def tableView(table_view, numberOfRowsInSection: section)
      sections[section].rows.count
    end

    def rows
      sections.first.rows
    end

    def tableView(table_view, cellForRowAtIndexPath: index_path)
      section = sections[index_path.section]
      row     = section.rows[index_path.row]

      table_view.dequeueReusableCellWithIdentifier(row.cell_identifier).tap do |cell|
        cell.label = row.name
        cell.icon  = row.icon
      end
    end
  end
end
