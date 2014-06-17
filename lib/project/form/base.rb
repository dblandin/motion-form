motion_require '../motion_form'
motion_require '../section/section'
motion_require '../views/section_header_view'

module MotionForm
  class Base < UITableView
    attr_reader :keyboard_avoiding_delegate

    def init
      initWithFrame(frame, style: UITableViewStylePlain).tap do |f|
        f.register_cells
        f.translatesAutoresizingMaskIntoConstraints = false

        f.dataSource = self
        f.delegate   = self

        f.addGestureRecognizer(tap_recognizer)

        @keyboard_avoiding_delegate = Motion::KeyboardAvoiding.new(f)

        listen
      end
    end

    def tap_recognizer
      @tap_recognizer ||= UITapGestureRecognizer.alloc.init.tap do |recognizer|
        recognizer.addTarget(self, action: 'tapped:')
      end
    end

    def tapped(recognizer)
      endEditing(true)
    end

    def listen
      observers << notification_center.addObserver(self, selector: 'did_begin_editing:', name: 'FormCellDidBeginEditing', object: nil)
      observers << notification_center.addObserver(self, selector: 'did_end_editing:', name: 'FormCellDidEndEditing', object: nil)
    end

    def did_begin_editing(notification)
      unless window.nil?
        keyboard_avoiding_delegate.textFieldDidBeginEditing(notification.userInfo[:text_field])
      end
    end

    def did_end_editing(notification)
      unless window.nil?
        keyboard_avoiding_delegate.textFieldDidEndEditing(notification.userInfo[:text_field])
      end
    end

    def observers
      @observers ||= []
    end

    def notification_center
      NSNotificationCenter.defaultCenter
    end

    def section(title = '')
      build_section(title).tap do |section|
        yield section
      end
    end

    def build_section(title)
      MotionForm::Section.new(title).tap do |section|
        sections << section
      end
    end

    def sections
      @sections ||= []
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

    def tableView(table_view, heightForRowAtIndexPath: index_path)
      section = sections[index_path.section]
      row     = section.rows[index_path.row]

      row.respondsToSelector('height') ? row.height : 44
    end

    def tableView(table_view, viewForHeaderInSection: section)
      unless sections[section].title.blank?
        SectionHeaderView.alloc.initWithFrame([[0, 0], [size.width, 44.0]]).tap do |header|
          header.text = table_view.tableView(table_view, titleForHeaderInSection: section)
        end
      end
    end

    def tableView(table_view, titleForHeaderInSection: section)
      sections[section].title
    end

    def tableView(table_view, heightForHeaderInSection: section)
      if sections[section].title.blank?
        0.0
      else
        44.0
      end
    end

    def rows
      sections.map(&:rows).flatten
    end

    def valid?
      notification_center.postNotificationName('FormWillValidate', object: self, userInfo: nil)

      rows.select { |row| row.is_a? TextInputRow }.all? { |row| row.valid? }
    end

    def tableView(table_view, cellForRowAtIndexPath: index_path)
      section = sections[index_path.section]
      row     = section.rows[index_path.row]

      table_view.dequeueReusableCellWithIdentifier(row.cell_identifier).tap do |cell|
        row.update_cell(cell)
      end
    end

    def render
      notification_center.postNotificationName('FormWillRender', object: self, userInfo: nil)

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
