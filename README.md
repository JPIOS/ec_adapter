# flutter适配器组建
### 说明主要是为了适配mvvm而存在，并需要遵守一下协议

#### 1 cell中需要遵守 ListViewCellType

#### 2 cellVM中需要遵守 ListViewItemType

#### 3 section的header和fotter需要遵循 ListViewHeaderFooterType

#### 4 sectionVM需要遵守 ListViewSectionItemType

#### 5 通过 AdapterListViewBuilder.builder创建listView并将ListViewAdapter实例对象传入其中

#### 6 刷新 
      - 不需要分组当时候：adapter.reloadSingleCell(cellVMList)
      - 需要分组当时候：this.adapter.reload(sections: sectionVMList)

### 垓项目会增加复杂度，但是层次会很清晰，对于复杂交互业务在后期维护更容易，同时也降低了项目耦合