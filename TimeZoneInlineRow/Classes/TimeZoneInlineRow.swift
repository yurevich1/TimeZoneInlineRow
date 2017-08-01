//
//  TimeZoneInlineRow.swift
//  TimeZoneInlineRow
//
//  Created by Vyacheslav Petrukhin on 12.09.16.
//  Copyright © 2016 PS. All rights reserved.
//

import Foundation
import Eureka

open class TimeZonePickerCell : Cell<TimeZone>, CellType, UIPickerViewDataSource, UIPickerViewDelegate {
    lazy open var timezones = TimeZone.knownTimeZoneIdentifiers
    open lazy var simplePicker: UIPickerView = { [unowned self] in
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(picker)
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[picker]-0-|", options: [], metrics: nil, views: ["picker": picker]))
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[picker]-0-|", options: [], metrics: nil, views: ["picker": picker]))
        
        return picker
        }()
    
    public required init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func setup() {
        super.setup()
        accessoryType = .none
        editingAccessoryType = .none
        simplePicker.delegate = self
        simplePicker.dataSource = self
    }
    
    open override func update() {
        super.update()
        selectionStyle = row.isDisabled ? .none : .default
        simplePicker.isUserInteractionEnabled = !row.isDisabled
        detailTextLabel?.text = nil
        textLabel?.text = nil
        
        simplePicker.selectRow(timezones.index(of: row.value?.identifier ?? TimeZone.current.identifier) ?? 0, inComponent: 0, animated: false)
        
        if row.isHighlighted {
            textLabel?.textColor = tintColor
        }
    }
    
    func TimeZonePickerValueChanged(_ sender: UIPickerView){
        row.value = TimeZone(identifier: timezones[sender.selectedRow(inComponent: 0)]) ?? TimeZone.current
        detailTextLabel?.text = row.displayValueFor?(row.value)
    }
    
    open override func cellCanBecomeFirstResponder() -> Bool {
        return canBecomeFirstResponder
    }
    override open var canBecomeFirstResponder: Bool {
        return !row.isDisabled
    }
    
    //MARK: - Delegates and data sources
    
    //MARK: Data Sources
    open func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    open func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timezones.count
    }
    
    //MARK: Delegates
    open func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timezones[row]
    }
    
    open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        TimeZonePickerValueChanged(pickerView)
    }
    
}

open class _TimeZonePickerRow : Row<TimeZonePickerCell> {
    
    required public init(tag: String?) {
        super.init(tag: tag)
        displayValueFor = nil
    }
}

public final class TimeZonePickerRow : _TimeZonePickerRow, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
    }
}

open class TimeZonesCell : Cell<String>, CellType, UIPickerViewDataSource, UIPickerViewDelegate {
    
    lazy open var simplePicker = UIPickerView()
    open var timezones = TimeZone.knownTimeZoneIdentifiers
    public required init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func setup() {
        super.setup()
        accessoryType = .none
        editingAccessoryType =  .none
        simplePicker.delegate = self
        simplePicker.dataSource = self
    }
    
    deinit {
        
    }
    
    open override func update() {
        super.update()
        selectionStyle = row.isDisabled ? .none : .default
        simplePicker.selectRow(timezones.index(of: row.value ?? TimeZone.current.identifier) ?? 0, inComponent: 0, animated: false)
        
        if row.isHighlighted {
            textLabel?.textColor = tintColor
        }
    }
    
    open override func didSelect() {
        super.didSelect()
        row.deselect()
    }
    
    override open var inputView : UIView? {
        if let _ = row.value {
            simplePicker.selectedRow(inComponent: 0)
        }
        return simplePicker
    }
    
    func TimeZonePickerValueChanged(_ sender: UIPickerView){
        row.value = timezones[sender.selectedRow(inComponent: 0)]
        detailTextLabel?.text = row.displayValueFor?(row.value)
        
    }
    
    open override func cellCanBecomeFirstResponder() -> Bool {
        return canBecomeFirstResponder
    }
    
    open override var canBecomeFirstResponder: Bool {
        return !row.isDisabled
    }
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    
    open func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    open func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timezones.count
    }
    
    //MARK: Delegates
    
    open func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timezones[row]
    }
    
    open func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        TimeZonePickerValueChanged(pickerView)
    }

}

open class _TimeZonesFieldRow: Row<TimeZonesCell>, NoValueDisplayTextConformance {

    open var noValueDisplayText: String? = nil
    
    required public init(tag: String?) {
        super.init(tag: tag)
        displayValueFor = { value in
            guard let val = value else { return nil }
            return val
        }
    }
}

//MARK: TimeZoneInlineRow

public typealias TimeZoneInlineRow = TimeZoneInlineRow_

open class TimeZoneInlineCell : Cell<TimeZone>, CellType {
    
    public required init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func setup() {
        super.setup()
        accessoryType = .none
        editingAccessoryType =  .none
    }
    
    open override func update() {
        super.update()
        selectionStyle = row.isDisabled ? .none : .default
    }
    
    open override func didSelect() {
        super.didSelect()
        row.deselect()
    }
}

open class _TimeZoneInlineFieldRow: Row<TimeZoneInlineCell>, NoValueDisplayTextConformance {
    
    open var noValueDisplayText: String?
    
    required public init(tag: String?) {
        super.init(tag: tag)
        
        displayValueFor = { value in
            guard let val = value else { return nil }
            return val.identifier
        }
    }
}

open class _TimeZoneInlineRow: _TimeZoneInlineFieldRow {
    
    public typealias InlineRow = TimeZonePickerRow
    
    public required init(tag: String?) {
        super.init(tag: tag)
    }
    
    open func setupInlineRow(_ inlineRow: TimeZonePickerRow) {
        
    }
}

public final class TimeZoneInlineRow_: _TimeZoneInlineRow, RowType, InlineRowType {
    
    required public init(tag: String?) {
        super.init(tag: tag)
        onExpandInlineRow { cell, row, _ in
            let color = cell.detailTextLabel?.textColor
            
            row.onCollapseInlineRow { cell, _, _ in
                cell.detailTextLabel?.textColor = color
            }
            
            cell.detailTextLabel?.textColor = cell.tintColor
        }
    }
    
    public override func customDidSelect() {
        super.customDidSelect()
        if !isDisabled {
            toggleInlineRow()
        }
    }
}
